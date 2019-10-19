/** PyQt5 binding for QCustomPlot v2.0.0
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli, Christopher Gilbert
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


class QCPItemStraightLine : public QCPAbstractItem /NoDefaultCtors/
{
%TypeHeaderCode
#include <QCustomPlot/src/items/item-straightline.h>
%End
public:
  explicit QCPItemStraightLine(QCustomPlot *parentPlot /TransferThis/);
  virtual ~QCPItemStraightLine();
  
  // getters:
  QPen pen() const;
  QPen selectedPen();
  
  // setters;
  void setPen(const QPen &pen);
  void setSelectedPen(const QPen &pen);
  
  // reimplemented virtual methods:
  virtual double selectTest(const QPointF &pos, bool onlySelectable, QVariant *details=0) const;
  
  QCPItemPosition * point1 /NoSetter/;
  QCPItemPosition * point2 /NoSetter/;

protected:
  // reimplemented virtual methods:
  virtual void draw(QCPPainter *painter);

  // non-virtual methods:
  QLineF getRectClippedStraightLine(const QCPVector2D &point1, const QCPVector2D &vec, const QRect &rect) const;
  QPen mainPen() const;
};
