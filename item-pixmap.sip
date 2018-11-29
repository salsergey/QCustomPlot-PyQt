/** PyQt5 binding for QCustomPlot v2.0.0
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli, Christopher Gilbert
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


class QCPItemPixmap : public QCPAbstractItem /NoDefaultCtors/
{
%TypeHeaderCode
#include <QCustomPlot/src/items/item-pixmap.h>
%End
public:
  explicit QCPItemPixmap(QCustomPlot *parentPlot);
  virtual ~QCPItemPixmap();
  
  // getters:
  QPixmap pixmap() const;
  bool scaled() const;
  Qt::AspectRatioMode aspectRatioMode() const;
  Qt::TransformationMode transformationMode() const;
  QPen pen() const;
  QPen selectedPen() const;
  
  // setters;
  void setPixmap(const QPixmap &pixmap);
  void setScaled(bool scaled, Qt::AspectRatioMode aspectRatioMode=Qt::KeepAspectRatio, Qt::TransformationMode transformationMode=Qt::SmoothTransformation);
  void setPen(const QPen &pen);
  void setSelectedPen(const QPen &pen);
  
  // reimplemented virtual methods:
  virtual double selectTest(const QPointF &pos, bool onlySelectable, QVariant *details=0) const;
  
  //QCPItemPosition * const topLeft;
  //QCPItemPosition * const bottomRight;
  //QCPItemAnchor * const top;
  //QCPItemAnchor * const topRight;
  //QCPItemAnchor * const right;
  //QCPItemAnchor * const bottom;
  //QCPItemAnchor * const bottomLeft;
  //QCPItemAnchor * const left;
};
